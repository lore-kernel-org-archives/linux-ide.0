From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] libata: add deadline support to prereset and reset
 methods
Date: Wed, 07 Mar 2007 06:45:38 -0500
Message-ID: <45EEA5E2.6000808@garzik.org>
References: <11704026523166-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35892 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbXCGLpp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Mar 2007 06:45:45 -0500
In-Reply-To: <11704026523166-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add @deadline to prereset and reset methods and make them honor it.
> ata_wait_ready() which directly takes @deadline is implemented to be
> used as the wait function.  This patch is in preparation for EH timing
> improvements.
> 
> * ata_wait_ready() never does busy sleep.  It's only used from EH and
>   no wait in EH is that urgent.  This function also prints 'be
>   patient' message automatically after 5 secs of waiting if more than
>   3 secs is remaining till deadline.
> 
> * ata_bus_post_reset() now fails with error code if any of its wait
>   fails.  This is important because earlier reset tries will have
>   shorter timeout than the spec requires.  If a device fails to
>   respond before the short timeout, reset should be retried with
>   longer timeout rather than silently ignoring the device.
> 
>   There are three behavior differences.
> 
>   1. Timeout is applied to both devices at once, not separately.  This
>      is more consistent with what the spec says.
> 
>   2. When a device passes devchk but fails to become ready before
>      deadline.  Previouly, post_reset would just succeed and let
>      device classification remove the device.  New code fails the
>      reset thus causing reset retry.  After a few times, EH will give
>      up disabling the port.
> 
>   3. When slave device passes devchk but fails to become accessible
>      (TF-wise) after reset.  Original code disables dev1 after 30s
>      timeout and continues as if the device doesn't exist, while the
>      patched code fails reset.  When this happens, new code fails
>      reset on whole port rather than proceeding with only the primary
>      device.
> 
>   If the failing device is suffering transient problems, new code
>   retries reset which is a better behavior.  If the failing device is
>   actually broken, the net effect is identical to it, but not to the
>   other device sharing the channel.  In the previous code, reset would
>   have succeeded after 30s thus detecting the working one.  In the new
>   code, reset fails and whole port gets disabled.  IMO, it's a
>   pathological case anyway (broken device sharing bus with working
>   one) and doesn't really matter.
> 
> * ata_bus_softreset() is changed to return error code from
>   ata_bus_post_reset().  It used to return 0 unconditionally.
> 
> * Spin up waiting is to be removed and not converted to honor
>   deadline.
> 
> * To be on the safe side, deadline is set to 40s for the time being.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c              |   18 +++--
>  drivers/ata/ata_generic.c       |    5 +-
>  drivers/ata/ata_piix.c          |   12 ++--
>  drivers/ata/libata-core.c       |  161 +++++++++++++++++++++++++++------------
>  drivers/ata/libata-eh.c         |   10 +-
>  drivers/ata/pata_ali.c          |   10 ++-
>  drivers/ata/pata_amd.c          |   16 ++--
>  drivers/ata/pata_artop.c        |    9 +-
>  drivers/ata/pata_atiixp.c       |    4 +-
>  drivers/ata/pata_cmd64x.c       |    8 +-
>  drivers/ata/pata_cs5520.c       |    4 +-
>  drivers/ata/pata_cs5530.c       |    4 +-
>  drivers/ata/pata_cs5535.c       |    5 +-
>  drivers/ata/pata_cypress.c      |    4 +-
>  drivers/ata/pata_efar.c         |    5 +-
>  drivers/ata/pata_hpt366.c       |    4 +-
>  drivers/ata/pata_hpt37x.c       |    9 +-
>  drivers/ata/pata_hpt3x2n.c      |    5 +-
>  drivers/ata/pata_hpt3x3.c       |    4 +-
>  drivers/ata/pata_it8213.c       |    5 +-
>  drivers/ata/pata_it821x.c       |    5 +-
>  drivers/ata/pata_jmicron.c      |    7 +-
>  drivers/ata/pata_marvell.c      |    5 +-
>  drivers/ata/pata_mpiix.c        |    4 +-
>  drivers/ata/pata_netcell.c      |    5 +-
>  drivers/ata/pata_ns87410.c      |    5 +-
>  drivers/ata/pata_oldpiix.c      |    5 +-
>  drivers/ata/pata_opti.c         |    5 +-
>  drivers/ata/pata_optidma.c      |    5 +-
>  drivers/ata/pata_pdc2027x.c     |    5 +-
>  drivers/ata/pata_pdc202xx_old.c |    9 +-
>  drivers/ata/pata_radisys.c      |    5 +-
>  drivers/ata/pata_rz1000.c       |    5 +-
>  drivers/ata/pata_serverworks.c  |    6 +-
>  drivers/ata/pata_sil680.c       |   10 ++-
>  drivers/ata/pata_sis.c          |   15 ++--
>  drivers/ata/pata_sl82c105.c     |    5 +-
>  drivers/ata/pata_triflex.c      |    5 +-
>  drivers/ata/pata_via.c          |    5 +-
>  drivers/ata/sata_inic162x.c     |   14 ++--
>  drivers/ata/sata_nv.c           |    5 +-
>  drivers/ata/sata_sil24.c        |   10 ++-
>  drivers/ata/sata_via.c          |    9 +-
>  include/linux/libata.h          |   24 ++++--
>  44 files changed, 296 insertions(+), 184 deletions(-)

applied 1-4 to #reset-seq



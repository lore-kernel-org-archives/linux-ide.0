From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.23-rc6-mm1: Build failure on ppc64 drivers/ata/pata_scc.c
Date: Tue, 25 Sep 2007 23:39:46 -0400
Message-ID: <46F9D482.8090407@garzik.org>
References: <20070918011841.2381bd93.akpm@linux-foundation.org> <20070920131315.GE24105@skynet.ie> <20070920150925.0caf3aef@the-village.bc.nu> <alpine.LFD.0.999.0709220816170.14412@enigma.security.iitk.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55434 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755452AbXIZDj5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 23:39:57 -0400
In-Reply-To: <alpine.LFD.0.999.0709220816170.14412@enigma.security.iitk.ac.in>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Satyam Sharma <satyam@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mel Gorman <mel@skynet.ie>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kamalesh@linux.vnet.ibm.com

Satyam Sharma wrote:
> Hi,
> 
> 
> On Thu, 20 Sep 2007, Alan Cox wrote:
>> On Thu, 20 Sep 2007 14:13:15 +0100
>> mel@skynet.ie (Mel Gorman) wrote:
>>
>>> PPC64 building allmodconfig fails to compile drivers/ata/pata_scc.c . It
>>> doesn't show up on other arches because this driver is specific to the
>>> architecture.
>>>
>>> drivers/ata/pata_scc.c: In function `scc_bmdma_status'
>> Its not been updated to match the libata core changes. Try something like
>> this. Whoever is maintaining it should also remove the prereset cable handling
>> code and use the proper cable detect method.
> 
> It appears you forgot to fix scc_std_softreset() and one of its callsites
> in scc_bdma_stop(). A complete patch is attempted below -- please review.
> 
> 
> [PATCH -mm] pata_scc: Keep up with libata core API changes
> 
> Little fixlets, that the build started erroring / warning about:
> 
> drivers/ata/pata_scc.c: In function 'scc_bmdma_status':
> drivers/ata/pata_scc.c:734: error: structure has no member named 'active_tag'
> drivers/ata/pata_scc.c: In function 'scc_pata_prereset':
> drivers/ata/pata_scc.c:866: warning: passing arg 1 of 'ata_std_prereset' from incompatible pointer type
> drivers/ata/pata_scc.c: In function 'scc_error_handler':
> drivers/ata/pata_scc.c:908: warning: passing arg 2 of 'ata_bmdma_drive_eh' from incompatible pointer type
> drivers/ata/pata_scc.c:908: warning: passing arg 3 of 'ata_bmdma_drive_eh' from incompatible pointer type
> drivers/ata/pata_scc.c:908: warning: passing arg 5 of 'ata_bmdma_drive_eh' from incompatible pointer type
> make[2]: *** [drivers/ata/pata_scc.o] Error 1
> 
> Signed-off-by: Satyam Sharma <satyam@infradead.org>
> Cc: Alan Cox <alan@redhat.com>
> Cc: Mel Gorman <mel@skynet.ie>
> 
> ---
> 
> Andrew, this includes (supercedes) the previous two ones from Mel / Alan.
> 
>  drivers/ata/pata_scc.c |   21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

applied



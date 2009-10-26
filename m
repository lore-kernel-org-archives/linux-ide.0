From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 04/16] pcmcia: use dynamic debug infrastructure,
	deprecate CS_CHECK (ide)
Date: Mon, 26 Oct 2009 16:33:33 +0100
Message-ID: <20091026153333.GA31865@comet.dominikbrodowski.net>
References: <20091024194219.GA19546@comet.dominikbrodowski.net> <1256413386-20501-4-git-send-email-linux@dominikbrodowski.net> <4AE5C4A5.7040403@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:39039 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752074AbZJZPjc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Oct 2009 11:39:32 -0400
Content-Disposition: inline
In-Reply-To: <4AE5C4A5.7040403@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org

Sergei,

On Mon, Oct 26, 2009 at 06:47:49PM +0300, Sergei Shtylyov wrote:
> Dominik Brodowski wrote:
>
>> ide-cs.c is the only PCMCIA device driver making use of CONFIG_PCMCIA_DEBUG,
>> so convert it to use the dynamic debug infrastructure.
>
>> Also, remove all usages of the CS_CHECK macro and replace them with proper
>> Linux style calling and return value checking. The extra error reporting may
>> be dropped, as the PCMCIA core already complains about any (non-driver-author)
>> errors.
>
>> CC: linux-ide@vger.kernel.org
>> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>> ---
>>  drivers/ata/pata_pcmcia.c |   16 ++++++++--------
>>  drivers/ide/ide-cs.c      |   32 +++++++++++---------------------
>>  2 files changed, 19 insertions(+), 29 deletions(-)
>
>    Please submit as two separate patches as ide and libata are two 
> separate subsystems.

thanks for your comment. And I see your point -- but as I intend to push this
upstream using the linux-pcmcia tree, as the IDE and ATA subsystems use the
same (linux-ide) mailing list, and as both drivers are quire related, I
thought handling both drivers in one patch is acceptable. If it still needs
to be done otherwise, I'll re-submit this patch in two parts and udpate my
workflow accordingly.

Best,
	Dominik

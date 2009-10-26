From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 04/16] pcmcia: use dynamic debug infrastructure, deprecate
 CS_CHECK (ide)
Date: Mon, 26 Oct 2009 18:47:49 +0300
Message-ID: <4AE5C4A5.7040403@ru.mvista.com>
References: <20091024194219.GA19546@comet.dominikbrodowski.net> <1256413386-20501-4-git-send-email-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:48762 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751446AbZJZOrT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 10:47:19 -0400
In-Reply-To: <1256413386-20501-4-git-send-email-linux@dominikbrodowski.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org

Hello.

Dominik Brodowski wrote:

> ide-cs.c is the only PCMCIA device driver making use of CONFIG_PCMCIA_DEBUG,
> so convert it to use the dynamic debug infrastructure.

> Also, remove all usages of the CS_CHECK macro and replace them with proper
> Linux style calling and return value checking. The extra error reporting may
> be dropped, as the PCMCIA core already complains about any (non-driver-author)
> errors.

> CC: linux-ide@vger.kernel.org
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  drivers/ata/pata_pcmcia.c |   16 ++++++++--------
>  drivers/ide/ide-cs.c      |   32 +++++++++++---------------------
>  2 files changed, 19 insertions(+), 29 deletions(-)

    Please submit as two separate patches as ide and libata are two separate 
subsystems.

WBR, Sergei


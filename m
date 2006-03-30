From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.16-g6ac37e95-dirty] ide: ATI SB600 IDE support
Date: Thu, 30 Mar 2006 14:09:04 -0800
Message-ID: <20060330140904.18197cd5.akpm@osdl.org>
References: <CAB45F03F8EF5B4992E343DBFC52032803076EB0@torcaexmb1.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:24723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751060AbWC3WHb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2006 17:07:31 -0500
In-Reply-To: <CAB45F03F8EF5B4992E343DBFC52032803076EB0@torcaexmb1.atitech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anatoli Antonovitch <antonovi@ati.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, jgarzik@pobox.com, linux-ide@vger.kernel.org

"Anatoli Antonovitch" <antonovi@ati.com> wrote:
>
> Description
> This patch adds support for the IDE device on ATI SB600

Thanks.

> Patch
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index
> 02f6cf2..4402e60 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h

Your email client is wordwrapping the patches and is replacing tabs with
spaces.

> 
> Signed-off-by: Felix Kuehling <fkuehlin@ati.com>
> 

Please put this at the end of the changelog, not at the end of the patch.


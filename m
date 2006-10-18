From: Aalderd Bouwman <aalderd.boac@wanadoo.nl>
Subject: Re: [PATCHSET] ahci updates regarding vt8251 support, take #2
Date: Wed, 18 Oct 2006 06:45:22 +0200
Message-ID: <1161146723.3008.2.camel@anja>
References: <11609522031228-git-send-email-htejun@gmail.com>
Reply-To: aalderd.boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-1.orange.nl ([193.252.22.241]:28713 "EHLO smtp-1.orange.nl")
	by vger.kernel.org with ESMTP id S932083AbWJREnp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Oct 2006 00:43:45 -0400
In-Reply-To: <11609522031228-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Hello Tejun,

I now have received the message in dmesg:
spurious 8259A interrupt: IRQ7.

What does it mean? And is it a problem for the properly working of the
system?

Aalderd.

On Mon, 2006-10-16 at 07:43 +0900, Tejun Heo wrote:
> Hello, all.
> 
> This is the second take of vt8251-ahci patchset.  This patchset
> updates libata and ahci to improve vt8251 EH and hotplug support.
> 
> #01 : separate out sata_port_hardreset(), to be used by vt8251 reset
> #02 : update CLO handling in softreset and kill RESET_NEEDS_CLO
> #03 : update vt8251 support in ahci
> 
> Changes from the last take[L] are
> 
> * rebased over the current upstream + hp-poll
> * hp-poll callbacks added to ahci_vt8251_ops
> 
> This patchset is against
>   upstream (da54f5fe54c7d75e2db7d17961fb36a8c28a8501)
>   + hp-poll patchset, take #5 [1]
> 
> This patchset has been verified by me and Aalderd Bouwman
> <aalderd.boac@wanadoo.nl>.
> 
> The git tree is avilable at
> 
>   http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=vt8251-ahci
>   git://htj.dyndns.org/libata-tj vt8251-ahci
> 
> Thanks.
> 
> --
> tejun
> 
> [L] http://article.gmane.org/gmane.linux.ide/13449
> [1] http://article.gmane.org/gmane.linux.ide/13467
> 
> 
> 


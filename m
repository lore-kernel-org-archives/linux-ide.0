From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/9] libata: fix several bugs in reworked legacy handling
Date: Wed, 09 Aug 2006 00:28:27 -0400
Message-ID: <44D9646B.2000507@pobox.com>
References: <11547252931996-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:63900 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030457AbWHIE2a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 00:28:30 -0400
In-Reply-To: <11547252931996-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, davej@redhat.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch fixes the following bugs from reworked legacy handling.
> 
> * In ata_pci_init_legacy_port(), probe_num was incorrectly incremented
>   during initialization of the secondary port and probe_ent->n_ports
>   was incorrectly fixed to 1.
> 
> * Both legacy ports ended up having the same hard_port_no.
> 
> * When printing port information, both legacy ports printed the first
>   irq.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, though it would be better for 'git bisect' if this was merged into 
the previous patch (#4).



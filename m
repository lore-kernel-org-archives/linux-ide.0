From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: SiS 965L version 0x0183
Date: Mon, 30 Oct 2006 00:00:32 +0100
Message-ID: <45453290.1080003@gmx.net>
References: <20061029160014.44572.qmail@web90509.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:726 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030418AbWJ2XAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Oct 2006 18:00:35 -0500
In-Reply-To: <20061029160014.44572.qmail@web90509.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bogus nominus <holister@yahoo.com>
Cc: linux-ide@vger.kernel.org

Hi,

Please try to exchange all 182 against 183 in sata_sis.c. This should
work for you.
I try to fix it completely.


bogus nominus wrote:
> I have a motherboard with yet another new revision of
> this driver that is not supported... I was going to
> attempt to update the driver myself but unfortunately
> I do not have enough time to do my due diligence to
> ensure I take everything into account.. 


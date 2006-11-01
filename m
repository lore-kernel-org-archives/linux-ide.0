From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/18] [PATCH] libata-link: separate out link initialization
 functions
Date: Tue, 31 Oct 2006 21:26:00 -0500
Message-ID: <454805B8.4040303@pobox.com>
References: <11609528803880-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44502 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946024AbWKAC0D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 21:26:03 -0500
In-Reply-To: <11609528803880-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out link initialization into ata_link_init() and
> ata_link_init_sata_spd_limit().

pushing the bounds of good taste, with a long function name :)



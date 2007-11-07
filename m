From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Date: Tue, 6 Nov 2007 20:09:33 -0800
Message-ID: <86802c440711062009t7e98d27fqdfb466b9843da060@mail.gmail.com>
References: <20061031104055.GA8898@infradead.org>
	 <15F501D1A78BD343BE8F4D8DB854566B0C8DDCF5@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:31039 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbXKGEJe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 23:09:34 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2666811wah
        for <linux-ide@vger.kernel.org>; Tue, 06 Nov 2007 20:09:33 -0800 (PST)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C8DDCF5@hkemmail01.nvidia.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

On Nov 7, 2006 1:55 AM, Peer Chen <pchen@nvidia.com> wrote:
> Modified and resent out the patch as attachment.
> Description about the patch:
> Add SGPIO support in sata_nv.c.
> SGPIO (Serial General Purpose Input Output) is a sideband serial 4-wire
> interface that a storage controller uses to communicate with a storage
> enclosure management controller, primarily to control activity and
> status LEDs that are located within drive bays or on a storage
> backplane. SGPIO is defined by [SFF8485].
> In this patch,we drive the LEDs to blink when read/write operation
> happen on SATA drives connect the corresponding ports on MCP55 board.
> ==========
> The patch will be applied to kernel 2.6.19-rc4-git9.

do you have one that can apply to 2.6.24-rc2 or current linus git tree.

YH

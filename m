From: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Too async libata breakage
Date: Thu, 8 Jan 2009 22:15:56 +0300
Message-ID: <b6fcc0a0901081115n1174aebj5f6a3fbb8adea789@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:19163 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896AbZAHTP7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2009 14:15:59 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: arjan@infradead.org, torvalds@osdl.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

commit f29d3b23238e1955a8094e038c72546e99308e61 aka
"fastboot: Make libata initialization even more async"
results in no findable /dev/sda2 to mount / here.

Kernel correctly sees sda as 750GB drive and the rest too.

CONFIG_ATA_PIIX is in use, everything built-in, plain partitions,
no initrd, DM, MD etc.

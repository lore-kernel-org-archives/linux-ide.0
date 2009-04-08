From: Timur Tabi <timur@freescale.com>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Wed, 08 Apr 2009 16:06:25 -0500
Message-ID: <49DD11D1.7060105@freescale.com>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>	 <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>	 <1239156559.10104.7.camel@localhost> <ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com> <49DD1154.3040106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:45328 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766009AbZDHVIn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2009 17:08:43 -0400
In-Reply-To: <49DD1154.3040106@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: michael@ellerman.id.au, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linux PPC Development <linuxppc-dev@ozlabs.org>

Tejun Heo wrote:

> Running "lspci -nnvvvxxx" before loading the driver should be enough.

That might be difficult.  My root file system is on my SATA drive.
It'll be a while before I can build an NFS rootfs.

-- 
Timur Tabi
Linux kernel developer at Freescale

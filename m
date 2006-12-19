From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 2.6.20-git] sata_svw: Check for errors from
	ata_device_add()
Date: Tue, 19 Dec 2006 18:33:51 -0500
Message-ID: <1166571231.5210.121.camel@gullible>
References: <1166569153.5210.116.camel@gullible>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adelie.ubuntu.com ([82.211.81.139]:48985 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932946AbWLSXeB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 18:34:01 -0500
In-Reply-To: <1166569153.5210.116.camel@gullible>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux Kernel List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tue, 2006-12-19 at 17:59 -0500, Ben Collins wrote:
> Without this patch, G5 oopses on boot. I've had this in Ubuntu since
> 2.6.17, but I forgot it was in there. Still required with 2.6.20.
> 
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>

Ignore this patch for now, BenH and I are discussing the issue further.

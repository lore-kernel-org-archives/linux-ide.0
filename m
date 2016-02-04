From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
Subject: Re: [PATCH v7] SATA: OCTEON: support SATA on OCTEON platform
Date: Thu, 4 Feb 2016 15:24:31 +0300
Message-ID: <56B342FF.1090709@caviumnetworks.com>
References: <1454520915-27948-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1on0060.outbound.protection.outlook.com ([157.56.110.60]:16715
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965392AbcBDNCz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Feb 2016 08:02:55 -0500
In-Reply-To: <1454520915-27948-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, tj@kernel.org, hdegoede@redhat.com
Cc: david.daney@cavium.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi Zubair,

> +	void __iomem *base;

[..]

> +	cfg = cvmx_read_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG);

sparse will complain here.  See Documentation/sparse.txt

Thank you
Aleksey Makarov

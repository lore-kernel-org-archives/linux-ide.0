From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Patch] SCSI: Add nvidia AHCI controllers of MCP67 support to
 ahci.c
Date: Tue, 31 Oct 2006 21:08:39 -0500
Message-ID: <454801A7.20002@pobox.com>
References: <15F501D1A78BD343BE8F4D8DB854566B0C42DBC9@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48853 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946392AbWKACIl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 21:08:41 -0500
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C42DBC9@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Peer Chen wrote:
> Yes,we use 0x010601 for AHCI controller.  But we also want AHCI driver take care our 'RAID'  controller,so Device IDs field in AHCI driver is necessary.

Agreed.  Just taking a survey of vendors :)  Most vendors similarly use
the RAID class code.

	Jeff




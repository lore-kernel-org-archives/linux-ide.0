From: "Andrew Chew" <achew@nvidia.com>
Subject: RE: [PATCH 2.6.7] new NVIDIA libata SATA driver
Date: Wed, 16 Jun 2004 18:19:34 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B4@mail-sc-6-bk.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate00.nvidia.com ([216.228.112.144]:34830 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S266343AbUFQBTq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2004 21:19:46 -0400
Content-class: urn:content-classes:message
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> From: Bartlomiej Zolnierkiewicz 

> Is there any reason why this driver doesn't support 
> CK804-SATA[2] and  MCP04-SATA[2]?

These will be supported by this driver eventually.  We probably can
change it now, but silicon isn't available for these yet so I wasn't
able to test the driver.

> Removing IDs from amd74xx.c is a bad idea,
> it breaks boot on systems already using these IDs.

I assume these systems will be able to boot using the libata subsystem.
Is that a bad assumption?

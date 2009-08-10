From: "Subbrathnam, Swaminathan" <swami.iyer@ti.com>
Subject: sata AHCI controller over non-PCI bus
Date: Mon, 10 Aug 2009 13:48:17 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5989152@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37466 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbZHJISY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Aug 2009 04:18:24 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7A8IJiE008236
	for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2009 03:18:25 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n7A8IJ6K013210
	for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2009 13:48:19 +0530 (IST)
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi,

            I would like to post support for OMAPL138 SATA controller that is AHCI 1.1 compliant.  OMAPL138 is an ARM926 based platform.

Current "ahci.c" assumes that AHCI is getting supported over PCI by default, whereas the SATA AHCI controller on OMAPL138 is connected to a non-PCI bus.  Since I am in the process of posting the support I would like to get the  opinion from the community on how to proceed on this front.  I see the following 2 options today

1.       #ifdef the PCI specific code in ahci.c and implement the platform_device based implementation to support non-PCI AHCI controllers.

2.       Re-organize the ahci.c to abstract the AHCI functionalities from PCI, non-PCI bus dependencies.

Currently we have implemented Option 1 in our internal tree to support SATA on OMAPL138 platform and it works well.  Ideally I would want to proceed with Option 2 but would like get feedback from the community before proceeding in this direction.

 

Regards

swami


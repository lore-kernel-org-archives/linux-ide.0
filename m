From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: ICH9 2 port SATA controller port map?
Date: Mon, 24 Sep 2007 13:36:46 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701CC0C09@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16179 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbXIXUhs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 16:37:48 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

ICH9 has DeviceID's for 2 port, IDE mode, SATA controllers.  The current
port map in ata_piix is setup for the 4 port controllers.  This seems to
work ok, but I wonder if a new port map should be defined for the 2 port
controllers, where the two ports are PM, SM?  You can refer to the ICH9
Datasheet on intel.com for detail.

Currently, ata_piix has ICH9 using this:

static const struct piix_map_db ich8_map_db = {
	.mask = 0x3,
	.port_enable = 0x3,
	.map = {
		/* PM   PS   SM   SS       MAP */
		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI)
*/
		{  RV,  RV,  RV,  RV },
		{  P0,  P2, IDE, IDE }, /* 10b (IDE mode) */
		{  RV,  RV,  RV,  RV },
	},
};

Thanks,

Jason

From: "Heasley, Seth" <seth.heasley@intel.com>
Subject: RE: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel
 Cougar Point DeviceIDs
Date: Wed, 13 Jan 2010 07:43:53 -0800
Message-ID: <CF9C39F99A89134C9CF9C4CCB68B8DDF12D391CB2A@orsmsx501.amr.corp.intel.com>
References: <201001121700.18234.seth.heasley@intel.com>
 <4B4D4EAA.2010109@gmail.com> <4B4DAA68.60608@pobox.com>
 <4B4DDFD3.5050700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19229 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755285Ab0AMPn5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jan 2010 10:43:57 -0500
In-Reply-To: <4B4DDFD3.5050700@redhat.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>> * some of lines of Intel chips do not separate AHCI into a separate PCI
>> ID rather legacy IDE interface.  When an AHCI interface exists and
>> AHCI/IDE share the same PCI ID, we default to using AHCI.  Thus, some of
>> those PCI ID matches in ahci.c's PCI table may not get caught by the
>> generic PCI class match at the end of the table.
>>
>> * the cost carrying redundant PCI IDs seems low, harmless, and
>> potentially helpful.
>
>It is helpful for the specific device IDs to show up in "modinfo ahci" and
>modules.pcimap.
>
>David

This is the reason I was asked to start adding the AHCI DeviceIDs here.

-Seth

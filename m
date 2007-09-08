From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: sata & scsi suggestion for make menuconfig
Date: Sat, 08 Sep 2007 18:44:46 +0200
Message-ID: <46E2D17E.9050805@s5r6.in-berlin.de>
References: <20070907124800.GP16806@vanheusden.com> <20070907083522.3191a4ba.randy.dunlap@oracle.com> <20070907155903.GR16806@vanheusden.com> <46E17A81.7020304@s5r6.in-berlin.de> <20070907230529.GX16806@vanheusden.com> <46E249CB.5070505@s5r6.in-berlin.de> <46E2CE73.3000207@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:37887 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbXIHQp6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 12:45:58 -0400
In-Reply-To: <46E2CE73.3000207@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Folkert van Heusden <folkert@vanheusden.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Randy Dunlap wrote:
> Stefan Richter wrote:
>> I am not a friend of 'select', but maybe the following actually helps.
...
> The problem with 'select' here is that it will enable BLK_DEV_SD,
> but if SCSI is not enabled, it will not become enabled -- i.e.,
> select does not follow the dependency chain.  So usually the
> kernel will not build unless SCSI is enabled by the user.
...
>> config ATA_SD
>>     tristate "SATA/PATA HDD support (via SCSI disk support)"
>>     depends on ATA
>>     select BLK_DEV_SD
>>     help
>>       'SCSI disk support' is required to access SATA HDDs.  It is
...

I checked the dependencies.  ATA depends on SCSI (actually, selects
SCSI), so all is well.  Otherwise I would have added more dependencies
to ATA_SD.
-- 
Stefan Richter
-=====-=-=== =--= -=---
http://arcgraph.de/sr/

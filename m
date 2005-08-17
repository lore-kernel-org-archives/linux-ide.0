From: "Naren (Narendra) Sankar" <nsankar@broadcom.com>
Subject: RE: [PATCH 2.6.13-rc6 ] (updated) serverworks: Add support for
 new southbridge IDE
Date: Wed, 17 Aug 2005 12:18:54 -0700
Message-ID: <8AFFB74283C8EF46ACA4C331087033F10F5C07@NT-SJCA-0750.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:35086 "EHLO
	MMS2.broadcom.com") by vger.kernel.org with ESMTP id S1751217AbVHQTTa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Aug 2005 15:19:30 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

It is added to svwks_csb_check -


@@ -109,6 +114,7 @@ static u8 svwks_csb_check (struct pci_de
 		case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
 		case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE:
 		case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2:
+		case PCI_DEVICE_ID_SERVERWORKS_HT1000IDE:
 			return 1;
 		default:
 			break; 


Thanks

Naren Sankar
System Architect
Chipset Product Line
Broadcom Corporation
2451 Mission College Blvd
Santa Clara, CA 95054
Office:  (408) 922-7143
Email:  nsankar@broadcom.com 

-----Original Message-----
From: linux-ide-owner@vger.kernel.org
[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Bartlomiej
Zolnierkiewicz
Sent: Wednesday, August 17, 2005 12:14 PM
To: Naren (Narendra) Sankar
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc6 ] (updated) serverworks: Add support for new
southbridge IDE

On 8/17/05, Naren (Narendra) Sankar <nsankar@broadcom.com> wrote:
> Hi Everyone

Hi,

> Description -
> 
> BCM5785 (HT1000) is a Opteron Southbridge from Serverworks/Broadcom 
> that Incorporates a single channel ATA100 IDE controller that is 
> functionally Identical to the Serverworks CSB6 IDE controller. This 
> patch adds support For the new PCI device ID and also the support for this
controller.

Patch looks fine but don't you need to also add HT1000 ID to
swvks_csb_check()?

Bartlomiej
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in the
body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html



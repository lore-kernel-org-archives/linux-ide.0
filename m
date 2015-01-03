From: mtths@nurfuerspam.de
Subject: inic162x
Date: Sat, 03 Jan 2015 21:25:28 +0100
Message-ID: <2171761.W9v3jf2zpF@c21>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail06do.versatel.de ([89.245.129.26]:42184 "EHLO
	mail06do.versatel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbACUcU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jan 2015 15:32:20 -0500
Received: from i5387af86.versanet.de (HELO nn) (eid-h4f8w@versanet.de@[83.135.175.134])
          (envelope-sender <mtths@nurfuerspam.de>)
          by mail06do.versatel.de (qmail-ldap-1.03) with ESMTPA
          for <linux-ide@vger.kernel.org>; 3 Jan 2015 20:25:37 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

a simple question about the module sata_inic162x: Is there a chance that the 
driver will reach a stable state?

A card with such a controller was used mainly for video recording - and, yes, 
there were errors ... After a short test it seemed that copying big files or 
many small files resulted in corrupted copies; only writing infrequently small 
files was okay. This applies to both channels / ports.

The card is an equip 111817 (S/N: 11072600052): 1 internal + 1 external port
Initio INIC-1622TA2
RAID-BIOS: version 1.11
lspci: 1101:1622

If you want additional information or tests, let me know.
(On the other hand: Mark it as broken - there are inexpensive alternatives 
...)

Matthias

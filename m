From: Vladimir Krivopalov <argenet@very-soft.com>
Subject: SATA II generation controllers reset problem
Date: Thu, 12 Feb 2009 12:44:05 +0600
Message-ID: <4993C535.10204@very-soft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.very-soft.com ([83.133.126.206]:38103 "EHLO
	mail.very-soft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbZBLHQg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Feb 2009 02:16:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Greetings, Jeff!

My name is Vladimir Krivopalov, and I work as software developer in 
VerySoft LLC, Russia.
We currently develop a project containing Linux and Windows client-side 
parts and have to implement 'hot reboot' from Linux to Windows for our 
purposes. We use kexec application and grub4dos bootloader for this.
There's a problem we discovered while developing our project in Linux 
part. It occurs when an effort to switch from protected mode to the real 
mode is taken and bootloader is started, but it fails while looking for 
the SATA II drives.
As for normal booting with grub4dos, it has no probmels with detecting 
SATA drives. It also finds all IDE drives and SATA I (that have 
IDE-compartible interface) normally.
We suppose the reason could be in that SATA II controllers aren't 
resetted properly. Could you please provide any explanations on how are 
they reset by default in libata library for Linux?

Best regards,
 Vladimir Krivopalov,
 Software developer.
 VerySoft LLC (www.very-soft.com)

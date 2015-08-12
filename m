From: "Andy Falanga (afalanga)" <afalanga@micron.com>
Subject: mocking EH
Date: Wed, 12 Aug 2015 15:35:57 +0000
Message-ID: <60F6FAE47D1BCE4380CC06D18F49789BE49AAD1B@NTXBOIMBX02.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:32351 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbbHLPf6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Aug 2015 11:35:58 -0400
Received: from mail.micron.com (ntxboicas03.micron.com [137.201.84.59])
	by mailout.micron.com (8.14.4/8.14.6) with ESMTP id t7CFZvj2001829
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 09:35:57 -0600
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Greetings,

I'm modifying the stock ahci driver in order for use in a lab environment.  When working with drives that don't have FW images yet, I must mock the standard EH methods.  This requires that I override the standard error handling techniques done in ahci.c with my own.  I've made it so that one can override via a property in /sys/class/scsi_host/hostN/... .  This works well.  Yet, my own functions are never called more than once.  What's worse is that when one toggles the alternative back to the standard, the regular EH never kicks in again either.  So, I'm apparently missing a setting, or clearing something, in the ata_port->ata_link->eh_context structure (not sure I got all of those structures correct).  What should be set on these in order for subsequent calls through the scsi_error_handle
 r() chain?

Andy

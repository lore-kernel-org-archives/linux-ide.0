From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/3] [RFC] SATA Asynchronous Notification for ATAPI devices
Date: Tue, 20 Mar 2007 17:52:16 -0700
Message-ID: <20070320175216.6b46d80d.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23599 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933345AbXCUAyt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Mar 2007 20:54:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Hi!  I was hoping you could give me some feedback on this partial
implementation of Asynchronous Notification for ATAPI devices as 
defined in SATA 2.5 and AHCI 1.1.  I am specifically concerned about
the method I used to expose this functionality to user space (so that
hal can stop polling if it finds we support this) and also which
device sends the event, as well as the type of event that is sent.

Thanks for your feedback.  These patches are against 2.6.20 btw.

Kristen

-- 

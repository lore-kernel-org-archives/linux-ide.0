From: "Shawn Starr" <sstarr@platform.com>
Subject: [2.6.12-rc6][SATA] sil driver - K8N-E Deluxe hanging with Maxtor SATA disk
Date: Fri, 10 Jun 2005 18:43:26 -0400
Message-ID: <9CD190F4AD92EC499A9397F49C8B0E4E01E8ECE6@catoexm04.noam.corp.platform.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailtir.platform.com ([192.219.104.248]:56537 "EHLO
	mailtir.platform.com") by vger.kernel.org with ESMTP
	id S261363AbVFJWn1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2005 18:43:27 -0400
Received: from catoexm04.noam.corp.platform.com (bridgehead.platform.com [172.25.241.154])
	by mailtir.platform.com (8.12.10/8.12.10) with ESMTP id j5AMcKpG001678
	for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2005 18:38:20 -0400 (EDT)
Content-Class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi Jeff, 

I tried your latest patch plus the other fix to this patch and the controller is still hanging with DMA WRITE timeouts.

http://lkml.org/lkml/2005/3/25/33

Any other solutions?

Shawn.

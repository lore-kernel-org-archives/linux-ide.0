From: Jesse Stockall <stockall@magma.ca>
Subject: IDE connector on Promise 20376 SATA controller
Date: Fri, 24 Sep 2004 17:20:40 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096060840.6059.4.camel@homer.blizzard.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.magma.ca ([206.191.0.250]:11488 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S268899AbUIXVUp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2004 17:20:45 -0400
Received: from mail4.magma.ca (mail4.magma.ca [206.191.0.222])
	by mx2.magma.ca (8.13.0/8.13.0) with ESMTP id i8OLKhcC028581
	for <linux-ide@vger.kernel.org>; Fri, 24 Sep 2004 17:20:44 -0400
Received: from [192.168.1.20] (ottawa-hs-209-217-84-157.d-ip.magma.ca [209.217.84.157])
	(authenticated bits=0)
	by mail4.magma.ca (8.13.0/8.13.0) with ESMTP id i8OLKecK027794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 24 Sep 2004 17:20:43 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

I just purchased a board with a Promise 20376 SATA raid controller that
also has am IDE connector for a single PATA drive. The sata_promise
driver does not see the drive attached to the IDE connector.

I found a few old posts where people indicated that it was on Jeff
Garziks TODO list. 

kernel version 2.6.9-rc2-mm3

Thanks

Jesse
Please CC me on replies

-- 
Jesse Stockall <stockall@magma.ca>


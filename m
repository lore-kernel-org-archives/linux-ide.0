From: "Andrew Chew" <AChew@nvidia.com>
Subject: RE: IDE class driver with SATA controllers
Date: Tue, 7 Sep 2004 17:21:35 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F96B2@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate02.nvidia.com ([216.228.112.145]:26639 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S268791AbUIHAVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Sep 2004 20:21:43 -0400
Content-class: urn:content-classes:message
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Jeff Garzik wrote:
> If you want to play, and don't care about lack of ATAPI support (i.e. 
> just disks), then it is possible today to do this.  #define 
> ATA_FORCE_PIO and play away :)

I don't see ATA_FORCE_PIO anywhere in the linux-2.6.9-rc1-bk14 tree.  Am
I looking for the wrong #define?

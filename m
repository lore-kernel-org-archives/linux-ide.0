From: "Arunkumar S" <arunkumar.krishnan@gmail.com>
Subject: Vendor name identification for ATAPI CD-ROM
Date: Thu, 6 Apr 2006 19:30:34 +0530
Message-ID: <a27c8df90604060700o6e0ce525jfcb9696061dad020@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:35652 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932082AbWDFOAe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Apr 2006 10:00:34 -0400
Received: by wproxy.gmail.com with SMTP id 69so139149wri
        for <linux-ide@vger.kernel.org>; Thu, 06 Apr 2006 07:00:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I need to capture the vendor name of ATAPI CD-ROM  in Linux 2.6 kernel.
The proc file /proc/ide/hda/model doesn't have Vendor name for all
CD-ROM drives.  Is there any approach using ioctl call to retrieve the
Vendor name.

Thanks in advance.
- Arun

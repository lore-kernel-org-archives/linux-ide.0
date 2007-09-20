From: Kantor Zsolt <kantorzsolt@yahoo.com>
Subject: DMA and block mode
Date: Thu, 20 Sep 2007 03:02:26 -0700 (PDT)
Message-ID: <319607.25661.qm@web35404.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web35404.mail.mud.yahoo.com ([66.163.179.113]:36574 "HELO
	web35404.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750789AbXITKC1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 06:02:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, the DMA read/write transfers are not influenced by the currently block mode setting only the
PIO modes are influenced? because the read/write sectors using multiple mode is made on the PIO 
protocol, and for DMA is no such read/write multiple sectors  

Thanks
  Kantor


      ____________________________________________________________________________________
Check out the hottest 2008 models today at Yahoo! Autos.
http://autos.yahoo.com/new_cars.html

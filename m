From: Richard Nolde <richard.nolde@centurylink.net>
Subject: Sata_inic 162x support is broken message
Date: Wed, 21 Jan 2015 14:34:36 -0700
Message-ID: <54C01B6C.90507@centurylink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.centurylink.net ([205.219.233.9]:15111 "EHLO
	smtp.centurylink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbbAUVzg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jan 2015 16:55:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've recently upgraded one of my older backup Linux boxes to Fedora 20 
(I know that 21 is out already, but 20 is what I running on my 
production box and I wanted to be able to fall back seamlessly). When I 
did this, I started getting an error message about he sata_inic 162x 
kernel module being borked. After tracing through various postings, it 
looks like this driver is going the way of the dodo bird.  However, it 
worked fine for me for four or five years, and I can remember no 
instances of data corruption. I have several of cards, sold under the 
SIIG nameplate as SC-SA1012-S1 v1.0 which has one internal SATA port and 
one external SATA port and another model SC-SAT212-S4 with two internal 
ports and no external ports. I have used these cards to attach external 
Hard disks with esata or USB options and disks up to 1 TB in size. I've 
also used the second port for internal disks and DVD drives.

I'm not a kernel developer, but I am a systems programmer and I 
contribute to the LibTiff distribution with a utility called tiffcrop 
and patches for some of the other utilities. Since I have an extra box 
or two in which I could run tests, I would volunteer to help anyone that 
would be interested in working on the driver by running tests as 
directed by the developer. I have built my own kernels in the past, so 
compiling a custom kernel with any set of options requested would not be 
an issue. Most of my extra boxes are 32 bit Intel boxes, but my backup 
box is a 64 bit AMD Athalon model. My production box is a 64 bit Intel 
x86-64 but I don't think it save to run test kernels on that as my job 
depends on it and the data on the disks.

Please let me know if I can be of assistance in revitalizing this driver.

Richard Nolde


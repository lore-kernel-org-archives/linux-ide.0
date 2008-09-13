From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Recommended PCI Express or PCI-X SATA (Raid) Controller?
Date: Sat, 13 Sep 2008 10:00:20 +0100
Message-ID: <f4527be0809130200i23053c1m34855368bac129c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:8282 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbYIMJAW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Sep 2008 05:00:22 -0400
Received: by ey-out-2122.google.com with SMTP id 6so523153eyi.37
        for <linux-ide@vger.kernel.org>; Sat, 13 Sep 2008 02:00:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I want to add a PCI Express or PCI-X SATA Controller to my system for
an additional 2 or 4 sata ports, however I am running Xen so I am
stuck with a older kernel version, gentoo xen 2.6.21 has proved to be
fairly stable on my hardware but I may attempt to upgrade to 2.6.25 if
necessary, can anybody recommend a pci-x or pci express sata
controller with 2 or 4 ports that has been well supported since at
least 2.6.21?

I assumed that any real hardware raid device would be beyond my budget
but I might just be able to afford a Areca ICAe1210, has anybody used
Areca cards with older kernels?

Thanks
Andy

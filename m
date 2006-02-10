From: Jeff Garzik <jgarzik@pobox.com>
Subject: libata janitor project
Date: Fri, 10 Feb 2006 06:54:35 -0500
Message-ID: <43EC7EFB.5020100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:15296 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751087AbWBJLyk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 06:54:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>


Long term, we should work to replace the assert() in libata with 
standard kernel WARN_ON().

If someone wanted to handle that conversion, that would be useful.  Make 
sure to pay attention, the sense of each test must be reversed.

	Jeff




From: Gene Stapp <genestapp@gmail.com>
Subject: Correct way to enable port multiplier support in kernel 2.6.20-1?
Date: Fri, 20 Apr 2007 08:37:13 -0500
Message-ID: <4628C209.6030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:38966 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992592AbXDTMhQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2007 08:37:16 -0400
Received: by wx-out-0506.google.com with SMTP id h31so966621wxd
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2007 05:37:16 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

I don't see any patches to get port multiplier support working for 
kernel 2.6.20-1  I recompiled the kernel manually and made sure I 
config'd it with everything current but it appears port multiplier isn't 
in the mainline (it still does not work).
My question is, what do I need to do to get my addonics 3726 working 
with kernel 2.6.20-1? I'm not a developer by any means and the guide on 
the addonics website would have worked for me but it is out of date.
http://www.addonics.com/support/faqs/faq-pmsupport_desktop.asp

Gene Stapp

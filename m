From: "Jon Nelson" <jnelson@jamponi.net>
Subject: Re: Lots of con-current I/O = resets SATA link? (2.6.25.10)
Date: Sat, 5 Jul 2008 12:35:24 -0500
Message-ID: <cccedfc60807051035q52354cf0mbb471915b7b33d6b@mail.gmail.com>
References: <alpine.DEB.1.10.0807051252200.12562@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:20059 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbYGERfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jul 2008 13:35:25 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1127296wri.5
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2008 10:35:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0807051252200.12562@p34.internal.lan>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, linux-ide@vger.kernel.org, xfs@oss.sgi.com, Alan Piszcz <ap@solarrain.com>

Try booting with:

nolapic

That largely fixed my problems on my motherboard (2.6.18+, EPoX MF-570SLI).
I hope to try 2.6.25+ soon.

-- 
Jon

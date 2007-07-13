From: "Daniel Filipiuk" <danielfilipiuk@gmail.com>
Subject: shutdown problem with 2.6.22 and debian 4.0
Date: Fri, 13 Jul 2007 09:07:48 -0300
Message-ID: <366cc2df0707130507r6dcdf970nbaa2aed1a640d3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:15346 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbXGMMHu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 08:07:50 -0400
Received: by nz-out-0506.google.com with SMTP id s18so426268nze
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 05:07:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello, I have a doubt... I have Debian 4.0 and the kernel 2.6.22
compiled by me, and now when I shutdown my machine, appears a message
telling that the devices (/dev/sda5 , 6 and so on..) are busy and
cannot be unmounted, and tells me that I must update my shutdown
utility... Then the system go halt ... It doesn=B4t seem to be any data
loss , but I don=B4t want to leave this error message forever hoping
that I don=B4t loose anything... With the kernel 2.6.21.5 this doesn=B4=
t
happened, and the mounts were succesfully unmounted. What should I do?
Where I found this "shutdown utility" source code?

Thank you very much, greetings,

Pd: sorry for my basic english! ;-)

Daniel Filipiuk

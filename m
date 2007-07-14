From: Tejun Heo <htejun@gmail.com>
Subject: Re: shutdown problem with 2.6.22 and debian 4.0
Date: Sat, 14 Jul 2007 13:10:35 +0900
Message-ID: <46984CBB.1060006@gmail.com>
References: <366cc2df0707130507r6dcdf970nbaa2aed1a640d3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:16035 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbXGNEKl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jul 2007 00:10:41 -0400
Received: by py-out-1112.google.com with SMTP id d32so1162669pye
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 21:10:40 -0700 (PDT)
In-Reply-To: <366cc2df0707130507r6dcdf970nbaa2aed1a640d3f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Filipiuk <danielfilipiuk@gmail.com>
Cc: linux-ide@vger.kernel.org, hmh@hmh.eng.br

Daniel Filipiuk wrote:
> Hello, I have a doubt... I have Debian 4.0 and the kernel 2.6.22
> compiled by me, and now when I shutdown my machine, appears a message
> telling that the devices (/dev/sda5 , 6 and so on..) are busy and
> cannot be unmounted, and tells me that I must update my shutdown
> utility... Then the system go halt ... It doesn=B4t seem to be any da=
ta
> loss , but I don=B4t want to leave this error message forever hoping
> that I don=B4t loose anything... With the kernel 2.6.21.5 this doesn=B4=
t
> happened, and the mounts were succesfully unmounted. What should I do=
?
> Where I found this "shutdown utility" source code?
>=20
> Thank you very much, greetings,

Dunno about the busy part but you need to update the shutdown utility.
Cc'ing Henrique.

--=20
tejun

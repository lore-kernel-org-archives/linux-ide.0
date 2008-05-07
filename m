From: "Bart Van Assche" <bart.vanassche@gmail.com>
Subject: Re: Compact Flash Question
Date: Wed, 7 May 2008 18:46:25 +0200
Message-ID: <e2e108260805070946t63f35e36q6960bdff11fecd8c@mail.gmail.com>
References: <48215673.3060201@wpkg.org>
	 <e2e108260805070044v42f596bbj39c5b52b6f0a096@mail.gmail.com>
	 <48216039.3070001@wpkg.org> <4821A12F.2020800@aitel.hist.no>
	 <4821C462.2000108@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:12620 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYEGQq2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 12:46:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so265215fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 07 May 2008 09:46:26 -0700 (PDT)
In-Reply-To: <4821C462.2000108@free.fr>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Tomasz Chmielewski <mangoo@wpkg.org>, LKML <linux-kernel@vger.kernel.org>, YSadgat1@gcte.com, linux-os@analogic.com, Alan <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Jeff Woods <jeff@jeffwoods.us>

On Wed, May 7, 2008 at 5:01 PM, St=E9phane ANCELOT <sancelot@free.fr> w=
rote:
>
> we use  silicon systems CF  with wear leveling inside  , we write a f=
ew
> kb data back each 1/4 h  on it.(log /tmp files  are redirected to ram=
)

Silicon Systems CompactFlashes are the among the most reliable
CompactFlashes I have used in embedded devices. See also
http://www.siliconsystems.com/silicondrive/whitepapers/SSWP03-Endurance=
-R.pdf
for a whitepaper that explains their wear leveling and error
correction algorithms. Furthermore, Silicon Systems has a technology
called SiSMART that allows to monitor by how far the CompactFlash is
worn out, such that it can be monitored whether or not it is time to
replace the CompactFlash. (Note: I am not affiliated in any way to
Silicon Systems.)

Bart.

From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: RE: Silent corruption on AMD64
Date: Mon, 2 Apr 2007 09:30:18 -0400
Message-ID: <003c01c7752b$0e678fa0$294b82ce@stuartm>
References: <20070401043905.GV15189@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965417AbXDBNam@vger.kernel.org>
In-Reply-To: <20070401043905.GV15189@vitelus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: 'Aaron Lehmann' <aaronl@vitelus.com>, 'Jim Paris' <jim@jtan.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: On Behalf Of Aaron Lehmann
> I've been able to narrow it down to the Realtek Ethernet card. I can't
> reproduce the problem using onboard Ethernet, whereas the Realtek card
> causes trouble in any slot. However, I still don't know whether it's a
> hardware or software issue, or whether it's caused directly or
> indirectly by the Realtek card.

I had a similar issue recently:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=223216

I recommend trying Doug Ledford's memtest script:
http://people.redhat.com/dledford/memtest.html

It helped me prove the issue was the hardware and not something else.

..Stu

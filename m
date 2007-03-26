From: rct@gherkin.frus.com (Bob Tracy)
Subject: Re: 2.6.21-rc4: known regressions with patches (v2)
Date: Mon, 26 Mar 2007 07:37:22 -0500 (CDT)
Message-ID: <20070326123722.4C17FDBA1@gherkin.frus.com>
References: <20070324112544.GB752@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752449AbXCZMhZ@vger.kernel.org>
In-Reply-To: <20070324112544.GB752@stusta.de> "from Adrian Bunk at Mar 24, 2007
 12:25:44 pm"
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, tglx@linutronix.de, johnstul@us.ibm.com, bzolnier@gmail.com
List-Id: linux-ide@vger.kernel.org

Adrian Bunk wrote:
> Subject    : boot hangs during IDE detection  (clocksource)
> References : http://lkml.org/lkml/2007/3/19/465
> Submitter  : Bob Tracy <rct@gherkin.frus.com>
> Caused-By  : John Stultz <johnstul@us.ibm.com>
>              commit 6bb74df481223731af6c7e0ff3adb31f6442cfcd
> Handled-By : John Stultz <johnstul@us.ibm.com>
> Patch      : http://lkml.org/lkml/2007/3/22/287
> Status     : workaround-patch available

The subject problem is fixed *without* the workaround patch in
2.6.21-rc5.  The acpi_pm clocksource patch for the case where the
PIIX4 bug is present should probably be included anyway.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

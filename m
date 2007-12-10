From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9533] New: 2.6.24-rc4: some ahci/acpi
 interaction causes delays during boot
Date: Mon, 10 Dec 2007 12:55:43 -0800
Message-ID: <20071210125543.80b1e841.akpm@linux-foundation.org>
References: <bug-9533-10286@http.bugzilla.kernel.org/>
	<20071210125243.df6b441e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20071210125243.df6b441e.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@sisk.pl, bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 10 Dec 2007 12:52:43 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 10 Dec 2007 05:55:20 -0800 (PST)
> bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=9533
> 
> Another box-killing regression to track, please.  Either ATA or ACPI.

er, no, not box-killing - just scary warnings.

It's not clear what "kernel doesn't get to userland yet" is referring to - 
something else I guess.

Your desire to avoid doing a bisection search is a good one - I've been
trying to do one for a couple of days on and off and there are so many
fatally buggy bisection points between 2.6.23 and 2.6.24-rc1 that I've
given up on the attempt.

From: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6] system is very slow during disk access
Date: Wed, 6 Aug 2003 15:04:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030806150434.53c4fa8c.akpm@osdl.org>
References: <200308062052.10752.fsdeveloper@yahoo.de>
	<200308062129.47113.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200308062129.47113.fsdeveloper@yahoo.de>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Michael Buesch <fsdeveloper@yahoo.de> wrote:
>
>  I just tried to run the test-scenario on my other Linux-installation
>  on this machine with kernel 2.4.10 and there the output of the program
>  was quite smooth, even it dd was running und the system was still usable.

Please boot the 2.6 machine with "profile=1" on the kernel boot command line.

start the `dd', do a `readprofile -r', wait ten seconds, do

	readprofile -m /wherever/System.map

then post the results.

Thanks.

From: David Rees <drees76@gmail.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Tue, 26 Jan 2010 16:32:49 -0800
Message-ID: <72dbd3151001261632t7bbe43d0nb7490eae02185c81@mail.gmail.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
	<20100126160243.018b87e3@lxorguk.ukuu.org.uk> <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
	<72dbd3151001261251s606ebf00h86c2ce63293305b6@mail.gmail.com>
	<aacba7e1001261621v6abb4270i996a28d19c9f7d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754183Ab0A0Ad0@vger.kernel.org>
In-Reply-To: <aacba7e1001261621v6abb4270i996a28d19c9f7d7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vishal Rao <vishalrao@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jan 26, 2010 at 4:21 PM, Vishal Rao <vishalrao@gmail.com> wrote:
> 2010/1/27 David Rees <drees76@gmail.com>:
>> Have there been any other reports of NCQ issues with similar Crucial
>> drives or Indilinx?
>
> I haven't personally seen reports of NCQ specific issues. I have seen
> people (online) reporting "issues" with Linux distro installations
> hanging/freezing etc. and some prior attempts at SMART fixes which
> I also initially tried but did not work for me.
>
> I have tried to "publicise" this issue (forum, blog, mailing list posts)
> in the hope more users may search and identify the correct issue
> so that it may be better verified.

See, that's just the problem.  I'm running couple OCZ SSD with an
Indilinx controller and also know that Mark Lord and a bunch of others
are also running them on Linux without issues.  And supposedly all the
Indilinx firmware for the different resellers are based on the same
base firmware.

I did have an issue with one of them on a particular motherboard
locking up, but it turned out that the whole SATA controller was flaky
and went away after I replaced the motherboard.

So my concern is that you're proposing to black list NCQ for all users
of those particular models of SSD when it's more likely at this point
that it's a problem with your specific setup.

-Dave

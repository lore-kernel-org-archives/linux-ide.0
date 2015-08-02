From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Check return code from pdc20621_i2c_read()
Date: Sun, 02 Aug 2015 11:03:43 -0700
Message-ID: <1438538623.1301.29.camel@perches.com>
References: <1438510340-21568-1-git-send-email-barletz@gmail.com>
	 <55BDFA5C.3040506@cogentembedded.com>
	 <CAO-S75CRyh=FPbeTJMZWiYTvpd_wn57f4eGQgOHW2p16+9ANhQ@mail.gmail.com>
	 <CAO-S75DznUxvYg9RPcDOaw1H8XK8MuXxFGOARVt-5OtW2_RJnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-S75DznUxvYg9RPcDOaw1H8XK8MuXxFGOARVt-5OtW2_RJnA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomer Barletz <barletz@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, 2015-08-02 at 10:55 -0700, Tomer Barletz wrote:
> Re-sending in plain-text.
> 
> On Sun, Aug 2, 2015 at 4:09 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> 
> >    Please use pr_err() instead. And "0x%d" makes no sense at all, 
> > please use "%#x" instead.
> > 
> 
> Yeah, not sure what I was drinking before writing this 0x%d thing...
> 
> Regarding the pr_err() - it is not used at all in this file, and
> printk() is used instead. Wouldn't it be better to leave it with
> printk for this change, then have another change that replaces
> printk()s with pr_err()s?

Where possible, it'd be better to use ata_dev_<level>

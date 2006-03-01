From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [ltp] ICH6M legacy hotswap?
Date: Wed, 1 Mar 2006 02:00:17 +0200
Message-ID: <41840b750602281600x75ed7c6diced291d50b76582a@mail.gmail.com>
References: <41840b750602280135j511a7584m80b0b1f549780bf@mail.gmail.com>
	 <20060228202642.GA15624@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:47979 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932725AbWCAAAS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 19:00:18 -0500
Received: by zproxy.gmail.com with SMTP id l1so4125nzf
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 16:00:17 -0800 (PST)
In-Reply-To: <20060228202642.GA15624@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-thinkpad@linux-thinkpad.org, linux-ide@vger.kernel.org

On 2/28/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> To the best of my knowledge, there is no way to get an ICH6 into AHCI
> mode if the BIOS has set it up in legacy mode.

Yeah, I've just found Jeff's posts on that.
It's a real shame, taking a perfectly good AHCI controller and using
it in legacy mode... I hope someone finds a way to hack it out.


> I wrote some code that
> basically does what lt_hotswap does for SATA devices that worked fine on
> my ICH6 test machine (a Dell rather than a Thinkpad, but shouldn't
> matter in this case), but it needs much more polish before it's
> integratable.

Eagerly awaited.

  Shem

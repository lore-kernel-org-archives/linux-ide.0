From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: Merging ATA passthru
Date: Fri, 21 Oct 2005 21:21:33 -0400
Message-ID: <20051022012130.GD28212@tuxdriver.com>
References: <43593E0A.4070801@pobox.com> <43596160.3080407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965191AbVJVBWS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43596160.3080407@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Oct 21, 2005 at 05:45:04PM -0400, Mark Lord wrote:

> With passthru, it would really be much better to just leave it enabled
> without any option.  It's NOT on any main code path, and users/distros
> have to intentionally run "smartctl -d ata" or "hdparm /dev/sd*" to
> trigger any of it.

Actually, that's a good point.  I'm forced to concur with my
colleague... :-)

John
-- 
John W. Linville
linville@tuxdriver.com

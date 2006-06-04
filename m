From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [2.6.17-rc5-mm2+ahci resume] NULL pointer dereference in cfq_dispatch_requests
Date: Sun, 04 Jun 2006 11:11:46 -0700
Message-ID: <44832262.3050701@goop.org>
References: <4482389F.6030403@goop.org> <20060603184134.ee6dcc3b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750880AbWFDSLw@vger.kernel.org>
In-Reply-To: <20060603184134.ee6dcc3b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Andrew Morton wrote:
> There have been a number of CFQ fixes post-2.6.17-rc5-mm2.  Fingers
> crossed, please test -mm3.  Hopefully I'll have that out 4-6 hours hence

mm3 seems to have fixed it.

    J

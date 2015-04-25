From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH] libata: Ignore spurious PHY events on LPM policy change
Date: Sat, 25 Apr 2015 19:57:18 +0200
Message-ID: <4018340.TCLCYqQ7qt@xps13>
References: <20150424214214.GD27034@htj.duckdns.org> <1429954469-27892-1-git-send-email-gabriele.mzt@gmail.com> <20150425153751.GA31335@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150425153751.GA31335@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: stripathi@apm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Saturday 25 April 2015 11:37:51 Tejun Heo wrote:
> I thought more about it and it's weird to have ATA_LFLAG_CHANGED and
> last_lpm_change timestamp in libata core side and then open-code the
> actual logic in ahci.  How about implementing a generic helper, say,
> bool sata_lpm_ignore_phy_events(link) in libata core and use it in
> specific drivers?  It can test both the current lpm_policy and the
> timeout (preferably a separate patch to introduce the function and
> factor out lpm policy testing).

I agree. I'm now going to send the revised patches, thanks for all
the suggestions.

Gabriele

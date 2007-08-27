From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH][resend] fix IDE legacy mode resources
Date: Mon, 27 Aug 2007 08:40:50 +0100
Message-ID: <46D29C22.76E4.0078.0@novell.com>
References: <20070824115559.06250ec0.yoichi_yuasa@tripeaks.co.jp>
 <20070824152005.45167160.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752460AbXH0Hke@vger.kernel.org>
In-Reply-To: <20070824152005.45167160.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: Martin Michlmayr <tbm@cyrius.com>, Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>, linux-ide@vger.kernel.org, Linux KernelMailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

>Please discuss.

I don't think there's much to discuss - Yoichi Yuasa's changes can be simply
brought through to the other patch (of which I continue to only state that X
has a problem, the patch fixes it for me [and perhaps *only* me], and afaik
X itself still hasn't been fixed in this respect).

Jan

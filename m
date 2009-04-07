From: Matthew Wilcox <willy@linux.intel.com>
Subject: Re: [PATCH 4/5] ide: Add support for TRIM
Date: Tue, 7 Apr 2009 15:15:54 -0700
Message-ID: <20090407221554.GA4527@linux.intel.com>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <20090402165117.GQ2661@linux.intel.com> <200904022137.35671.bzolnier@gmail.com> <200904072339.00224.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761877AbZDGWQR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200904072339.00224.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, David Woodhouse <David.Woodhouse@intel.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Apr 07, 2009 at 11:38:59PM +0200, Bartlomiej Zolnierkiewicz wrote:
> I would like to see this merged for -rc1 so I tried to put it altogether
> and then integrate it over recent IDE and block changes...

You're missing 1/5 and 2/5.  This patch will crash horribly if you use
it with a drive which supports TRIM.

From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Single host/multiple hwifs vs. multiple hosts?
Date: Mon, 09 Apr 2012 21:24:59 -0400
Message-ID: <4F838BEB.5090802@teksavvy.com>
References: <CAMuHMdX1iwCwH+NXF7wP+pTMZzkUiR+DOrjjrVFWmtQUsktC=w@mail.gmail.com> <CAMuHMdXKUVU8WWVD_fd4XpB3-scsfrJjOVQ6D1D=jAMmi-qhsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:60126 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab2DJBeh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2012 21:34:37 -0400
In-Reply-To: <CAMuHMdXKUVU8WWVD_fd4XpB3-scsfrJjOVQ6D1D=jAMmi-qhsQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>

On 12-04-08 05:12 AM, Geert Uytterhoeven wrote:
> On Sun, Mar 4, 2012 at 13:15, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> I'm wondering what are the differences between adding a single IDE host with
>> multiple hwifs vs. adding a separate IDE host for each hwif?
>> Do both ways work?
> 
> Does no one know?

When I first wrote that code, the idea was that if a given chip
had multiple IDE ports (hardware interfaces, or hwifs for short),
then that's how it would be done.  One controller, multiple hwifs.

This was before IDE had anything to do with the SCSI subsystem,
and allowed for things like controller chips which could operate
only a single hwif at any point in time (aka. "serialized").

Nowadays, the code's be hacked beyond recognition from its original form
and intent, so who knows!  :)




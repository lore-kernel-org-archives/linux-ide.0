From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [IDE] Fix build bug
Date: Fri, 2 Nov 2007 12:34:30 +0000
Message-ID: <20071102123428.GA14106@linux-mips.org>
References: <20071025135334.GA23272@linux-mips.org> <200710301134.30087.vda.linux@googlemail.com> <20071030124155.GA7582@linux-mips.org> <200711011843.16894.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:48315 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbXKBMfH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 08:35:07 -0400
Received: from localhost.localdomain ([127.0.0.1]:15555 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030388AbXKBMfF (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Fri, 2 Nov 2007 12:35:05 +0000
Content-Disposition: inline
In-Reply-To: <200711011843.16894.vda.linux@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, Martijn Uffing <mp3project@sarijopen.student.utwente.nl>

On Thu, Nov 01, 2007 at 06:43:16PM +0000, Denys Vlasenko wrote:

> We can intrduce new, ro sections or teach gcc that combining const objects into
> non-ro sections is not a crime. I wonder why it currently disallows that.
> (And it does it only _somethimes_, const pointers happily go into rw sections!)

The pattern seems to be that const-ness of the first object placed into
a particular section determines the writability of that section.  If that
conflicts with the requirements for a later object such as a non-const
object into a section r/o gcc doesn't consider making the section r/w
but throws an error instead.

  Ralf

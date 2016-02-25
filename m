From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [REGRESSION] 8a3e33cf92c7 "ata: ahci: find eSATA ports and flag
 them as removable" changes userspace behavior
Date: Thu, 25 Feb 2016 19:48:58 +0100
Message-ID: <CAOLZvyF1mA3HOhy5RxnA4VuP5ju6+o+8UR9RzBAK8N4Mj2fy=w@mail.gmail.com>
References: <56CF35FA.1070500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38070 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933225AbcBYStj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Feb 2016 13:49:39 -0500
In-Reply-To: <56CF35FA.1070500@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Feb 25, 2016 at 6:12 PM, Laura Abbott <labbott@redhat.com> wrote:
> Hi,
>
> We received a bugzilla report
> https://bugzilla.redhat.com/show_bug.cgi?id=1310682
> of partitions being automounted unexpectedly. Testing showed that
> 8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as removable") was
> responsible.
> This seems to be classified as 'breaking' userspace given that this behavior
> results
> in partitions that were previously unmounted now being being mounted
> unwanted
> automatically which is unwanted behavior for the user. Can we revert this
> patch or
> give a fix to change this behavior?

This patch doesn't cause esata disks to be automounted on my distro (gentoo),
it just let's them appear in KDE's removable device widget for me
to mount it at a klick's notice.
I'm not convinced this is a "breaking userspace" problem.

Manuel

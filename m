From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.0-test9: BUG alim15x3.c
Date: Sun, 2 Nov 2003 16:45:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200311021645.54838.bzolnier@elka.pw.edu.pl>
References: <20031102150911.GB14148@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20031102150911.GB14148@pusa.informat.uv.es>
Content-Disposition: inline
To: uaca@alumni.uv.es
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sunday 02 of November 2003 16:09, uaca@alumni.uv.es wrote:
> Hi all

Hi,

> I have an ASUS P5A board with the ALI M5229 IDE controller, the kernel
> (2.6.0-test9) doesn't recognize the partition table (so it cannot but
> the root fs of the disk).

Does it recognize drives correctly?  Does ALI driver oops?
Do you have support for your filesystem compiled-in (not as module).
Have you tried passing "root=/dev/hda" (or similar) boot parameter?

--bartlomiej

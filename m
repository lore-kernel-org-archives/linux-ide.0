From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Tue, 24 Jun 2008 16:33:38 +0200
Message-ID: <58cb370e0806240733q5a6987f4q7f103e3864b09e62@mail.gmail.com>
References: <87k5gmz596.fsf@denkblock.local>
	 <200806240041.42796.bzolnier@gmail.com>
	 <87skv3s3d9.fsf@denkblock.local>
	 <200806241306.42054.bzolnier@gmail.com>
	 <20080624133218.6bccab75@lxorguk.ukuu.org.uk>
	 <58cb370e0806240621g61370f56j660e31790dad89c3@mail.gmail.com>
	 <20080624143548.24dcf511@lxorguk.ukuu.org.uk>
	 <58cb370e0806240719o4a70537p4a6fb64e9086e2d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:39084 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbYFXOdk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 10:33:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1185025fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 24 Jun 2008 07:33:39 -0700 (PDT)
In-Reply-To: <58cb370e0806240719o4a70537p4a6fb64e9086e2d8@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

On Tue, Jun 24, 2008 at 4:19 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:

[...]

> IOW while the two operations are very similar on the drive level they
> certainly have different needs and requirements at the higher level
> (abort operation being especially tricky).

The confusion seems to be caused by unfortunate use of the word
'hardware' in my initial mail ('system' should be more proper)...

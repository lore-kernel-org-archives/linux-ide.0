From: Roland Dreier <roland@topspin.com>
Subject: Re: [PATCH] libata update
Date: 06 Jan 2004 08:33:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <52ekudvxy4.fsf@topspin.com>
References: <200401041413.20573.marchand@kde.org> <3FFA80BE.2040205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3FFA80BE.2040205@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Jeff and others,

On the topic of Silicon Image SATA support, how do things look for
supporting the SiI 3512?  This chip seems to be pretty common on
Nforce3 boards.

I had a look on the SiI web site and they say the programming
interface is very close to the 3112.  Unfortunately their data sheets
don't seem to be freely available so I can't tell how close the
interface really is (or do the work to add 3512 support myself).

Thanks,
  Roland

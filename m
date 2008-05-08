From: Soeren Sonnenburg <kernel@nn7.de>
Subject: 2.6.26-git: ata_piix link is slow to respond regression.
Date: Thu, 08 May 2008 19:30:42 +0200
Message-ID: <1210267842.4175.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758521AbYEHRbe@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Dear all,

my macbook pro1,1 I suddenly hangs when booting current mainstream with=
:

ata_piix 0000:00:1f.2 MAP [P0 P2 -- -- ]
link is slow to respond, please be patient =EF=BB=BF(ready=3D0)
SRST failed =EF=BB=BF(errno=3D-1f)

these errors are repeated to hard resets follow but not use.

Soeren

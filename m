From: F Baube <fbaube@welho.com>
Subject: PROBLEM: 2.5.40 IDE "dirty" flag crashes 2.4.18
Date: Sun, 6 Oct 2002 03:48:36 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20021006034836.A6334@welho.com>
Reply-To: fbaube@welho.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: fbaube@welho.com

2.5.40 IDE "dirty" flag crashes 2.4

- I have my root and boot partitions on an IDE drive
- I built and booted a 2.5.40 kernel
- Oddly, on this bootup "kudzu" was triggered
- More importantly, when the 2.5.40 kernel failed to recognize my=20
  keyboard (probably a bad config) I did a hard reboot (the red button)
- On the next bootup I selected my stock Redhat 2.4.18 kernel
- The 2.4.18 kernel was loaded from the /boot partition okay
- After some preliminaries, the 2.4.18 kernel froze with a kernel panic=
,=20
  complaining about my root partition and an unrecognised "attribute(4)=
" =20
- I used a rescue disk and "e2fsck -f" to mark the root partition as =20
  cleanly unmounted (and also to rewrite the partition type ("Linux"))
- This fixed it -- the next boot into 2.4.18 went smoothly

My best guess is that when 2.5.40 marked the drive as dirty, it did=20
so using a flag value which is extremely not-backward-compatible with=20
2.4.18.


terveisi=E4 Helsingist=E4,

f baube
fbaube @ welho.com


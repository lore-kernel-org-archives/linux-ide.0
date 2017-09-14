From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] libata: Add new med_power_with_dipm link_power_management_policy setting
Date: Thu, 14 Sep 2017 12:35:35 +0200
Message-ID: <20170914103536.7650-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi All,

As described by Matthew Garret quite a while back:
https://mjg59.dreamwidth.org/34868.html

On Intel CPUs starting with the Haswell generation SATA link power
management can save a significant amount of power.

Previous attempts to try and enable SATA LPM by default have gotten stuck
on ome reports of some disks / SSDs not liking min_power leading to system
crashes and in some cases even data corruption has been reported.

This patch is another attempt to make the default Windows IRST driver
settings Matthew found available under Linux, but instead of changing
medium_power and potentially introducing regressions, this commit adds
a new med_power_with_dipm setting.

I've done a blog post asking people to test this new settings on laptops:
https://hansdegoede.livejournal.com/18412.html

As mentioned there my goal is to enable med_power_with_dipm as default
LPM setting for laptops for Fedora 28 (to be released aprox. May 2018).

How exactly this will be done is still up for debate, one option would
be a kernel patch which recognizes the mobile variant of Intel's chipset
and changes the default on those, another option is punting this to
userspace.

Regards,

Hans
